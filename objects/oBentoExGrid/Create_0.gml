// Feather disable all

//Always call this in events in objects that inherit from `oBentoAncestor`!
event_inherited();

BentoVarEnsureMany(
    "columns",    2,
    "rows",       2,
    "minColumns", undefined,
    "minRows",    undefined,
    "maxColumns", undefined,
    "maxRows",    undefined,
);

BentoLayoutGrid(columns, rows, minColumns, minRows, maxColumns, maxRows);