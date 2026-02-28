
;;; ------------------------------------------------------------
;;; FIXTB.LSP
;;; Deletes block "TitleBlock1117", purges it, detaches xref "manac.png",
;;; reinserts the block at 0,0, toggles IMAGEFRAME 1 -> 0.
;;; Works in AutoCAD / AutoCAD Electrical 2026.
;;; ------------------------------------------------------------

(vl-load-com)

(defun c:FIXTB ( / *error* oldCMDECHO blkName imgName ss foundPath

                   DetachImage
                   EraseBlockRefs
                   PurgeBlock
                   InsertBlock
                 )

  (defun *error* (msg)
    (if oldCMDECHO (setvar 'CMDECHO oldCMDECHO))
    (if (and msg (not (wcmatch (strcase msg) "*CANCEL*,*QUIT*")))
      (princ (strcat "\nError: " msg))
    )
    (princ)
  )

  (setq oldCMDECHO (getvar 'CMDECHO))
  (setvar 'CMDECHO 0)

  ;; --- Configurable names (hard-coded as requested) ---
  (setq blkName "TitleBlock1117")
  (setq imgName "manac.png")

  ;; ----------------- Helpers -----------------
  (defun EraseBlockRefs (name / ss)
    ;; Erase all INSERTs of the block at model/paper space
    (setq ss (ssget "X" (list (cons 0 "INSERT") (cons 2 name))))
    (if ss
      (progn
        (command "_.ERASE" ss "")
        (princ (strcat "\nErased instances of block: " name))
      )
      (princ (strcat "\nNo visible instances of block found: " name))
    )
  )

  (defun PurgeBlock (name /)
    ;; Purge the block definition until gone
    (while (tblsearch "BLOCK" name)
      (command "_.-PURGE" "_B" name "_N")
    )
    (if (tblsearch "BLOCK" name)
      (princ (strcat "\nCould not purge block (still referenced): " name))
      (princ (strcat "\nBlock purged (if existed): " name))
    )
  )

  (defun DetachImage (name /)
    ;; Try with full name as given
    (command "_.-XREF"  "_D" name)
    (princ (strcat "\nTried to detach image/xref: " name " (and base name)."))
  )

  (defun InsertBlock (name / candidate fpath)
    ;; Find TitleBlock1117.dwg in search paths or ask the user
    (setq candidate (strcat name ".dwg"))
    (setq fpath (findfile candidate))
    (if (not fpath)
      (setq fpath (getfiled (strcat "Select " candidate) (getvar "DWGPREFIX") "dwg" 0))
    )
    (if fpath
      (progn
        ;; Use -INSERT with path so it (re)defines the block and places it
        ;; Point=0,0  Scale=1  Rotation=0
        (command "_.-INSERT" fpath "0,0" 1 1 0)
        (princ (strcat "\nInserted " name " at 0,0 from: " fpath))
        T
      )
      (progn
        (princ (strcat "\nBlock file not found: " candidate " — insertion skipped."))
        nil
      )
    )
  )

  ;; ----------------- Workflow -----------------
  (princ "\n--- FIXTB start ---")

  ;; 1) Delete all instances of the block
  (EraseBlockRefs blkName)

  ;; 2) Purge its definition (loop until gone)
  (PurgeBlock blkName)

  ;; 3) Detach the image/xref manac.png
  ;; (DetachImage imgName)

  ;; 4) Reinsert the TitleBlock1117 at 0,0 (from DWG file)
  (if (InsertBlock blkName)
    (progn
      ;; 5) Toggle IMAGEFRAME 1 then 0
      (setvar "IMAGEFRAME" 1)
      (setvar "IMAGEFRAME" 0)
      (command "_.REGEN")
      (princ "\nIMAGEFRAME toggled 1 -> 0. Done.")
    )
  )

  (setvar 'CMDECHO oldCMDECHO)
  (princ "\n--- FIXTB end ---")
  (princ)
)
