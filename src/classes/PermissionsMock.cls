@IsTest
public class PermissionsMock extends Permissions
{
    public static Set<String> accessibleFields = new Set<String>();
    public static Set<SObjectType> accessibleObjects = new Set<SObjectType>();
    
    public static void whitelist(String field) { accessibleFields.add(field); }
    public static void whitelist(SObjectType sObjectType) { accessibleObjects.add(sObjectType); }
    
    protected override Boolean canAccess(SObjectType sObjectType)
    {
        return accessibleObjects.contains(sObjectType);
    }
    protected override Boolean canAccess(SObjectType sObjectType, String fieldPath)
    {
        return accessibleFields.contains(fieldPath);
    }
    
    public class All extends Permissions
    {
        protected override Boolean canAccess(SObjectType sObjectType) { return true; }
        protected override Boolean canAccess(SObjectType sObjectType, String fieldPath) { return true; }
    }
    public class None extends Permissions
    {
        protected override Boolean canAccess(SObjectType sObjectType) { return false; }
        protected override Boolean canAccess(SObjectType sObjectType, String fieldPath) { return false; }
    }
}