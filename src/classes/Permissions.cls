public virtual class Permissions
{    
    static Permissions runningUser = new Permissions();
    @TestVisible static void setMock(Permissions mock) { runningUser = mock; }
    
    public static Boolean isAccessible(SObjectType sObjectType)
    {
        return runningUser.canAccess(sObjectType);
    }
    public static Boolean isAccessible(SObjectType sObjectType, String fieldPath)
    {
        return runningUser.canAccess(sObjectType, fieldPath);
    }
    public static Boolean isAccessible(SObjectType sObjectType, FieldExpression expression)
    {
        return runningUser.canAccess(sObjectType, expression);
    }
    public static Boolean isAccessible(SObjectType sObjectType, FieldOrder ordering)
    {
        return runningUser.canAccess(sObjectType, ordering);
    }
    public static Boolean isAccessible(SObjectType sObjectType, Predicate.Expression expression)
    {
        return runningUser.canAccess(sObjectType, expression);
    }
    
    protected virtual Boolean canAccess(SObjectType sObjectType)
    {
        return sObjectType.getDescribe().isAccessible();
    }
    protected virtual Boolean canAccess(SObjectType sObjectType, String fieldPath)
    {
        SObjectField field = DescribeCache.getField(sObjectType, fieldPath);
        return (field == null) ? false : field.getDescribe().isAccessible();
    }
    protected Boolean canAccess(SObjectType sObjectType, FieldExpression expression)
    {
        if (expression == null) return false;
        if (expression.fieldPath != null)
            return canAccess(sObjectType, expression.fieldPath);
        if (expression.sObjectType != null)
            return canAccess(expression.sObjectType);
        return expression.toString() == FieldExpression.count().toString();
    }
    protected Boolean canAccess(SObjectType sObjectType, FieldOrder ordering)
    {
        return (ordering == null) ? false : canAccess(sObjectType, ordering.field);
    }
    protected Boolean canAccess(SObjectType sObjectType, Predicate.Expression expression)
    {
        if (expression == null) return false;
        return (expression instanceOf DataCategory) ? true :
        	canAccess(sObjectType, expression.getFieldPath());
    }
}