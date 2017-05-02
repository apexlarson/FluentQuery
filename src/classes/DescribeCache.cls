global class DescribeCache
{
    static final Map<SObjectType, Map<String, ChildRelationship>> relationships =
        new Map<SObjectType, Map<String, ChildRelationship>>();
    
    global static ChildRelationship getChildRelationship(SObjectType sObjectType, String name)
    {
        if (relationships.containsKey(sObjectType))
            return relationships.get(sObjectType).get(name);
        Map<String, ChildRelationship> children = new Map<String, ChildRelationship>();
        for (ChildRelationship relation : sObjectType.getDescribe().getChildRelationships())
            children.put(relation.getRelationshipName(), relation);
        relationships.put(sObjectType, children);
        return children.get(name);
    }
}