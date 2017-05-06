global class DataCategory implements Predicate.Expression
{
    global Enum Selector { AT, ABOVE, BELOW, ABOVE_OR_BELOW }
    
    Selector filteringSelector;
    String dataCategoryGroupName, dataCategoryName;
    global DataCategory(String categoryGroup)
    {
        dataCategoryGroupName = categoryGroup;
    }
    global override String toString()
    {
        return dataCategoryGroupName +
            ' ' + String.valueOf(filteringSelector) +
            ' ' + dataCategoryName;
    }
    public String getFieldPath() { return null; }
    
    global DataCategory at(String category)
    {
        return filter(Selector.AT, category);
    }
    global DataCategory above(String category)
    {
        return filter(Selector.ABOVE, category);
    }
    global DataCategory below(String category)
    {
        return filter(Selector.BELOW, category);
    }
    global DataCategory aboveOrBelow(String category)
    {
        return filter(Selector.ABOVE_OR_BELOW, category);
    }
    DataCategory filter(Selector filteringSelector, String dataCategoryName)
    {
        this.dataCategoryName = dataCategoryName;
        this.filteringSelector = filteringSelector;
        return this;
    }
}