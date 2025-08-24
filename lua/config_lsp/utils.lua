---Merge recursively two tables without modifying them and return a new table.
local function merge_tables(t1, t2)
    local result = {}

    for k, v in pairs(t1) do
        if type(v) == "table" then
            result[k] = merge_tables(v, {})
        else
            result[k] = v
        end
    end

    for k, v in pairs(t2) do
        if type(v) == "table" then
            if type(result[k]) == "table" then
                result[k] = merge_tables(result[k], v)
            else
                result[k] = merge_tables(v, {})
            end
        else
            result[k] = v
        end
    end

    return result
end

return {
    merge_tables = merge_tables,
}
