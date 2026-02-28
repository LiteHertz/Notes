# Notes ACADE – Alexis Fortin

## Types de fichiers
- **WDP** : Fichier mère du projet.
- **WDT** : (Non documenté)
- **WDL** : Indique le nom de chaque ligne de description du projet.
- **WDN** : (Non documenté)
- **wd_desc.wdd** : Possiblement utile pour standardiser la description des plans.
- **wd_fam.dat** : Utilisé pour modifier les standards de nomenclature.
- **DWG** : Dessin AutoCAD.
- **DWS** : Drawing standards.
- **CHX** : Drawing checkfiles.
- **AEPX** : Lien AutoCAD Electrical &harr; Inventor.
- **BAK** : Fichier backup.
- **DST** : Sheetset.
- **SV$** : Sauvegarde automatique temporaire.
- **wd.env** : Fichier de configuration principale d’ACADE.
- **default.inst / default.loc** : Localisations supplémentaires.

## Gestion des projets
- Copier le projet terminé en ajoutant la date.
- Mode dynamique permet d'écrire dans la barre de commande sans cliquer.
- ACADe utilise des librairies personnalisables.
- Technique réseau : renommer `wd.env` en `wd.env.bak` puis distribuer.
- Attention aux chemins personnalisés dans `wd.env`.

## Modification de l’affichage
- Possible d’afficher localisation ou description plutôt que noms de dessins.
- Description 1 à 3 : Nom du projet, N/A, unique au dessin.

## Copier un dessin entre projets
1. Copier via Windows.
1. Ajouter le dessin dans ACADe.
1. Renommer.
1. Réajouter les descriptions.

## Suppression des dessins
- Supprimer dans ACADe puis dans Windows.

## Outils pratiques
- Liste d’exceptions pour voir les différences de paramètres.
- Appliquer valeurs par défaut du projet via clic droit.
- Template par défaut AutoCAD : Options &rarr; Files &rarr; Template Settings.
- Bordure d’image au plot : `IMAGEFRAME = 0`.

## XREFS
Les fichiers de xrefs sont sauvegardés dans `C:\AUTOCADXREFS`
> 1. Logo manac &rarr; `manac.png`
