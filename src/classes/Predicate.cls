public virtual class Predicate
{
    public interface Expression { String toString(); String getFieldPath(); }
    
    final Expression expression;
    final List<Predicate> children;
    
    public Predicate(Expression expression) { this.expression = expression; }
    Predicate(Predicate left, Predicate right)
    {
        children = new List<Predicate>();
        if (!sharesType(left)) children.add(left);
        else children.addAll(left.children);
        if (!sharesType(right)) children.add(right);
        else children.addAll(right.children);
    }
    public override String toString()
    {
        if (children == null) return expression.toString();
        List<String> clauses = new List<String>();
        for (Predicate child : children)
            clauses.add(incorporate(child));
        return String.join(clauses, getDelimiter());
    }
    public Predicate respectPermissions(SObjectType sObjectType)
    {
        if (children != null)
        {
            for (Integer i = children.size() - 1; i >= 0; i--)
                if (null == children[i].respectPermissions(sObjectType))
                    children.remove(i);
            return !children.isEmpty() ? this : null;
        }
        return Permissions.isAccessible(sObjectType, expression) ? this : null;
    }
    
    @TestVisible virtual String getDelimiter() { return null; }
    @TestVisible virtual Boolean sharesType(Predicate that) { return false; }
    String incorporate(Predicate that)
    {
        return (that.children == null && !sharesType(that)) ?
            that.toString() : '(' + that.toString() + ')';
    }
    
    public Predicate andX(Predicate that) { return new AndPredicate(this, that); }
    public Predicate andX(Expression expression) { return andX(new Predicate(expression)); }
    public Predicate orX(Predicate that) { return new OrPredicate(this, that); }
    public Predicate orX(Expression expression) { return orX(new Predicate(expression)); }
    
    class AndPredicate extends Predicate
    {
        AndPredicate(Predicate left, Predicate right) { super(left, right); }
        override Boolean sharesType(Predicate that) { return that instanceOf AndPredicate; }
        override String getDelimiter() { return ' AND '; }
    }
    class OrPredicate extends Predicate
    {
        OrPredicate(Predicate left, Predicate right) { super(left, right); }
        override Boolean sharesType(Predicate that) { return that instanceOf OrPredicate; }
        override String getDelimiter() { return ' OR '; }
    }
}