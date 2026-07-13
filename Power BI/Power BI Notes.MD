# Power BI Notes

Default resolution `1280 x 720`

## Power BI Queries tab

Main Element Types

1. Queries : transformation steps for data. Ex. change date format, qualify sale...
2. Parameters : queries that store reusable data (no transformations, reference elements)
3. Functions : reusable query logic as a function (used to reduce redundancy)

## Scope & Reusability Chart

### Variables in let...in

- **Scope**: Local only to that query
- **Reusable**: ❌ NOT accessible in other queries
- **Lifespan**: Disappear after query completes
- **Example**: `MyVar = 5` inside a query

### Parameters

- **Scope**: GLOBAL (accessible everywhere)
- **Reusable**: ✅ YES
- **Access Method**: `Parameter.ParameterName`
- **Best For**: Changing values dynamically
- **Example**: `Parameter.TaxRate`, `Parameter.FilePath`

### Functions (Fx)

- **Scope**: GLOBAL (callable from any query)
- **Reusable**: ✅ YES
- **Access Method**: `FunctionName(input1, input2)`
- **Best For**: Reusable logic/transformations
- **Example**: `AddTaxColumn(Table)`, `FilterByDate(Table, Date)`

### Other Queries

- **Scope**: Referenceable by name globally
- **Reusable**: ✅ YES (full output only)
- **Access Method**: `QueryName`
- **Best For**: Chaining transformations
- **Example**: `Sales_Raw`, `Customer_Cleaned`
