global class FieldOrder
{
    final FieldExpression field;
    String sortOrder, nullOrder;
    
    global FieldOrder(SObjectField field) { this(String.valueOf(field)); }
    global FieldOrder(String field) { this(new FieldExpression(field)); }
    global FieldOrder(FieldExpression field) { this.field = field; }
    
    global FieldOrder ascending()
    {
        sortOrder = 'ASC';
        return this;
    }
    global FieldOrder descending()
    {
        sortOrder = 'DESC';
        return this;
    }
    
    global FieldOrder nullsFirst()
    {
        nullOrder = 'NULLS FIRST';
        return this;
    }
    global FieldOrder nullsLast()
    {
        nullOrder = 'NULLS LAST';
        return this;
    }
    
    global override String toString()
    {
        String expression = field.toString();
        if (sortOrder != null)
            expression += ' ' + sortOrder;
        if (nullOrder != null)
            expression += ' ' + nullOrder;
        return expression;
    }
}