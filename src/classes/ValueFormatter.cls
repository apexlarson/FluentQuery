global class ValueFormatter
{
    global class FormattingException extends Exception { }
    global static String format(Object input)
    {
        if (input == null) return '' + String.valueOf(input);
        if (input instanceOf Builder) return '(' + String.valueOf(input) + ')';
        if (input instanceOf DateLiteral) return String.valueOf(input);
        if (input instanceOf Boolean) return String.valueOf(input);
        if (input instanceOf Double) return String.valueOf(input);
        if (input instanceOf String) return formatString(input);
        
        // any Date instance is also an instance of Datetime, and hence Date must preceed Datetime
        if (input instanceOf Date) return formatDate(input);         // Date must preceed Datetime
        if (input instanceOf Datetime) return formatDatetime(input); // Date must preceed Datetime
        
        return formatCollection(input);
    }
    global static String formatString(Object input)
    {
        return '\'' + String.escapeSingleQuotes((String)input) + '\'';
    }
    global static String formatDate(Object input)
    {
        Date d = (Date)input;
        return Datetime.newInstance(d.year(), d.month(), d.day()).format('yyyy-MM-dd');
    }
    global static String formatDatetime(Object input)
    {
        return Datetime.valueOf(input).format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'');
    }
    global static String formatCollection(Object input)
    {
        if (input instanceOf List<Object>)
        {
            List<String> values = new List<String>();
            for (Object element : (List<Object>)input)
                values.add(format(element));
            return '(' + String.join(values, ',') + ')';
        }
        if (input instanceOf Set<String>)
            return formatCollection(new List<String>((Set<String>)input));
        if (input instanceOf Set<Integer>)
            return formatCollection(new List<Integer>((Set<Integer>)input));
        if (input instanceOf Set<Decimal>)
            return formatCollection(new List<Decimal>((Set<Decimal>)input));
        if (input instanceOf Set<Double>)
            return formatCollection(new List<Double>((Set<Double>)input));
        if (input instanceOf Set<Long>)
            return formatCollection(new List<Long>((Set<Long>)input));
        if (input instanceOf Set<Date>)
            return formatCollection(new List<Date>((Set<Date>)input));
        if (input instanceOf Set<Datetime>)
            return formatCollection(new List<Datetime>((Set<Datetime>)input));
        else
            throw new FormattingException('Could not format value - ' + input);
    }
}