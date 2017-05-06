global virtual class Builder
{
    public final SObjectType sObjectType;
    final List<FieldExpression> fields, groupings;
    final List<String> cubeGroupings, rollupGroupings;
    final List<FieldOrder> orderings;
    
    Id withUserId;
    Integer rowLimit, offset;
    FilterScope filterScope;
    Predicate wherePredicate, havingPredicate, categoryPredicate;
    Boolean isForView, isForReference, isForUpdate;
    Boolean updateTracking, updateViewStat;
    
    global Builder(SObjectType sObjectType)
    {
        this.sObjectType = sObjectType;
        this.fields = new List<FieldExpression>();
        this.groupings = new List<FieldExpression>();
        this.cubeGroupings = new List<String>();
        this.rollupGroupings = new List<String>();
        this.orderings = new List<FieldOrder>();
        
        this.isForView = false;
        this.isForUpdate = false;
        this.isForReference = false;
        this.updateTracking = false;
        this.updateViewStat = false;
    }
    
    global Builder selectX(SObjectField field) { return selectX(String.valueOf(field)); }
    global Builder selectX(String field) { return selectX(new FieldExpression(field)); }
    global Builder selectX(FieldExpression field) { fields.add(field); return this; }
    global Builder selectX(List<SObjectField> fields)
    {
        for (SObjectField field : fields) selectX(field); return this;
    }
    global Builder selectX(List<String> fields)
    {
        for (String field : fields) selectX(field); return this;
    }
    global Builder selectX(List<FieldExpression> fields) { this.fields.addAll(fields); return this; }
    global Builder selectX(FieldSet fieldSet) { return selectX(fieldSet.getFields()); }
    @TestVisible Builder selectX(List<FieldSetMember> members)
    {
        List<String> fieldPaths = new List<String>();
        for (FieldsetMember member : members)
            fieldPaths.add(member.getFieldPath());
        return selectX(fieldPaths);
    }
    
    global Builder usingScope(FilterScope filterScope) { this.filterScope = filterScope; return this; }
    
    global Builder whereX(Filter filter) { return whereX(new Predicate(filter)); }
    global Builder havingX(Filter filter) { return havingX(new Predicate(filter)); }
    global Builder andX(Filter filter)
    {
        return (havingPredicate == null) ?
            whereX(wherePredicate.andX(filter)) :
            havingX(havingPredicate.andX(filter));
    }
    global Builder orX(Filter filter)
    {
        return (havingPredicate == null) ?
            whereX(wherePredicate.orX(filter)) :
            havingX(havingPredicate.orX(filter));
    }
    Builder whereX(Predicate predicate) { wherePredicate = predicate; return this; }
    Builder havingX(Predicate predicate) { havingPredicate = predicate; return this; }
    
    public Builder withUserId(Id userId) { withUserId = userId; return this; }
    public Builder withDataCategory(DataCategory category) { categoryPredicate = new Predicate(category); return this; }
    public Builder andX(DataCategory category) { categoryPredicate = categoryPredicate.andX(category); return this; }
    
    global Builder groupBy(SObjectField grouping) { return groupBy(String.valueOf(grouping)); }
    global Builder groupBy(String grouping) { return groupBy(new FieldExpression(grouping)); }
    global Builder groupBy(FieldExpression grouping) { groupings.add(grouping); return this; }
    
    global Builder groupByRollup(SObjectField grouping) { return groupByRollup(String.valueOf(grouping)); }
    global Builder groupByRollup(String grouping) { rollupGroupings.add(grouping); return this; }
    
    global Builder groupByCube(SObjectField grouping) { return groupByCube(String.valueOf(grouping)); }
    global Builder groupByCube(String grouping) { cubeGroupings.add(grouping); return this; }
    
    global Builder orderBy(String field) { return orderBy(new FieldExpression(field)); }
    global Builder orderBy(SObjectField field) { return orderBy(String.valueOf(field)); }
    global Builder orderBy(FieldExpression field) { return orderBy(new FieldOrder(field)); }
    global Builder orderBy(FieldOrder field) { orderings.add(field); return this; }
    
    global Builder limitX(Integer rowLimit) { this.rowLimit = rowLimit; return this; }
    global Builder offset(Integer offset) { this.offset = offset; return this; }
    
    global Builder forView() { this.isForView = true; return this; }
    global Builder forReference() { this.isForReference = true; return this; }
    global Builder forUpdate() { this.isForUpdate = true; return this; }
    
    global Builder updateTracking() { this.updateTracking = true; return this; }
    global Builder updateViewStat() { this.updateViewStat = true; return this; }
    
    global List<SObject> getRecords()
    {
        return Database.query(top().toString());
    }
    global SObject getRecord()
    {
        return Database.query(top().toString());
    }
    global Integer count()
    {
        fields.clear(); fields.add(FieldExpression.count());
        return Database.countQuery(top().toString());
    }
    global override String toString()
    {
        respectPermissions();
        return String.format('SELECT {0} FROM {1}{2}{3}{4}{5}{6}{7}{8}{9}{10}{11}', new List<String> {
            getSelectClause(), getTableName(), getScopeClause(),
            getWhereClause(), getWithClause(), getGroupByClause(),
            getHavingClause(), getOrderByClause(), getLimitClause(),
            getOffsetClause(), getForClauses(), getUpdateClauses()
        });
    }
    virtual void enforceObjectAccess()
    {
        if (!Permissions.isAccessible(sObjectType))
        {
            NoAccessException e = new NoAccessException();
            e.setMessage(String.valueOf(sObjectType));
            throw e;
        }
    }
    void respectPermissions()
    {
        enforceObjectAccess();
        
        Integer i;
        if (!fields.isEmpty())
            for (i = fields.size() - 1; i >= 0; i--)
                if (!Permissions.isAccessible(sObjectType, fields[i])) fields.remove(i);
        if (!groupings.isEmpty())
            for (i = groupings.size() - 1; i >= 0; i--)
                if (!Permissions.isAccessible(sObjectType, groupings[i])) groupings.remove(i);
        if (!rollupGroupings.isEmpty())
            for (i = rollupGroupings.size() - 1; i >= 0; i--)
                if (!Permissions.isAccessible(sObjectType, rollupGroupings[i])) rollupGroupings.remove(i);
        if (!cubeGroupings.isEmpty())
            for (i = cubeGroupings.size() - 1; i >= 0; i--)
                if (!Permissions.isAccessible(sObjectType, cubeGroupings[i])) cubeGroupings.remove(i);
        if (!orderings.isEmpty())
            for (i = orderings.size() - 1; i >= 0; i--)
                if (!Permissions.isAccessible(sObjectType, orderings[i])) orderings.remove(i);
        if (wherePredicate != null)
            wherePredicate = wherePredicate.respectPermissions(sObjectType);
        if (havingPredicate != null)
            havingPredicate = havingPredicate.respectPermissions(sObjectType);
    }
    virtual String getTableName()
    {
        return String.valueOf(sObjectType);
    }
    String getSelectClause()
    {
        List<String> queryFields = new List<String>();
        for (FieldExpression field : fields)
            if (field != null)
                queryFields.add(field.toString());
        if (queryFields.isEmpty())
            queryFields.add('Id');
        return String.join(queryFields, ',');
    }
    String getScopeClause()
    {
        return (filterScope == null) ? '' :
            ' USING SCOPE ' + String.valueOf(filterScope);
    }
    String getWhereClause()
    {
        return (wherePredicate == null) ? '' :
            ' WHERE ' + wherePredicate.toString();
    }
    String getWithClause()
    {
        String clause;
        if (withUserId != null)
            clause = new Filter('UserId').equals(withUserId).toString();
        else if (categoryPredicate != null)
            clause = 'DATA CATEGORY ' + categoryPredicate.toString();
        return (clause == null) ? '' : ' WITH ' + clause;
    }
    String getGroupByClause()
    {
        String clause;
        if (!groupings.isEmpty())
        {
            List<String> expressions = new List<String>();
            for (FieldExpression grouping : groupings)
                expressions.add(grouping.toString());
            clause = String.join(expressions, ',');
        }
        if (!rollupGroupings.isEmpty())
            clause = FieldExpression.rollup(rollupGroupings).toString();
        if (!cubeGroupings.isEmpty())
            clause = FieldExpression.cube(cubeGroupings).toString();
        return (clause == null) ? '' :
            ' GROUP BY ' + clause;
    }
    String getHavingClause()
    {
        return (havingPredicate == null) ? '' : ' HAVING ' + havingPredicate.toString();
    }
    String getOrderByClause()
    {
        if (orderings.isEmpty()) return '';
        List<String> expressions = new List<String>();
        for (FieldOrder ordering : orderings)
            expressions.add(ordering.toString());
        return ' ORDER BY ' + String.join(expressions, ',');
    }
    String getLimitClause()
    {
        return (rowLimit == null) ? '' : ' LIMIT ' + rowLimit;
    }
    String getOffsetClause()
    {
        return (offset == null) ? '' : ' OFFSET ' + offset;
    }
    String getForClauses()
    {
        String clause = '';
        if (isForReference) clause += ' FOR REFERENCE';
        else if (isForView) clause += ' FOR VIEW';
        if (isForUpdate) clause += ' FOR UPDATE';
        return clause;
    }
    String getUpdateClauses()
    {
        List<String> clauses = new List<String>();
        if (updateTracking) clauses.add('TRACKING');
        if (updateViewStat) clauses.add('VIEWSTAT');
        return clauses.isEmpty() ? '' : ' UPDATE ' + String.join(clauses, ',');
    }
    
    global virtual Builder top() { return this; }
    global virtual Builder queryChildren(String relationshipName)
    {
        ChildRelationship relation = DescribeCache.getChildRelationship(sObjectType, relationshipName);
        if (relation == null) throw new InvalidRelationshipException(relationshipName);
        return new ChildBuilder(this, relation);
    }
    
    class ChildBuilder extends Builder
    {
        final Builder parent;
        final String relationshipName;
        ChildBuilder(Builder parent, ChildRelationship relation)
        {
            super(relation.getChildSObject());
            this.parent = parent;
            
            relationshipName = relation.getRelationshipName();
        }
        public override Builder top() { return parent.selectX(new FieldExpression(this)); }
        override String getTableName() { return relationshipName; }
        override void enforceObjectAccess()
        {
            // FieldExpression will be stripped out as needed
        }
    }
}