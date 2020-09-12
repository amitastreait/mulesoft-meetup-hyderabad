import * from dw::util::Diff
import * from dw::core::Arrays

type Matcher = {
    "type": String,
    expected: Array
} {class: "org.mule.munit.assertion.api.matchers.Matcher"}

type MatcherDiff = Diff {class: "org.mule.munit.assertion.api.matchers.Diff"}

fun createDiff(expected:String, actual:String, path: String): Diff = {
    matches: false,
    diffs: [{ expected: expected, actual: actual, path: path }]
}
fun createMatch(): Diff = {
    matches: true,
    diffs: []
}

var notStringDiff = (value) -> createDiff("String", typeOf(value), "(root)") as MatcherDiff

//Core Matchers
fun equalTo(value: Any, equalToConfig: {unordered?: Boolean} = {}): Matcher  = {
    "type": "equalTo",
    expected: [(actual) -> do {
        diff(actual, value, equalToConfig) as MatcherDiff
    }]
} as Matcher

fun not(matcherOrValue: Any): Matcher  = {
    "type": "not",
    expected: [if (matcherOrValue is Matcher) matcherOrValue else equalTo(matcherOrValue)]
} as Matcher

fun notNullValue(): Matcher = {
    "type" : "notNullValue",
    expected: [(actual) -> do {
        if(actual != null) createMatch() as MatcherDiff
        else createDiff("not null", write(actual), "(root)") as MatcherDiff
    }]
} as Matcher

fun nullValue(): Matcher = {
    "type" : "nullValue",
    expected: [(actual) -> do {
        if(actual == null) createMatch() as MatcherDiff
        else createDiff("null", write(actual), "(root)") as MatcherDiff
    }]
} as Matcher

fun both(matcher1: Matcher, matcher2:Matcher): Matcher = {
    "type" : "both",
    expected: [matcher1, matcher2]
} as Matcher

fun either(matcher1: Matcher, matcher2:Matcher): Matcher = {
    "type" : "either",
    expected: [matcher1, matcher2]
} as Matcher

fun withEncoding(encoding:String|Null = null): Matcher = {
    "type" : "withEncoding",
    expected: [encoding]
} as Matcher

fun withMediaType(mediaType: String): Matcher = {
    "type" : "withMediaType",
    expected: [mediaType]
} as Matcher

fun allOf(matchers: Array<Matcher>): Matcher = {
    "type" : "allOf",
    expected: matchers
} as Matcher

fun anyOf(matchers: Array<Matcher>): Matcher = {
    "type" : "anyOf",
    expected: matchers
} as Matcher

//String Matchers
fun matches(regex: String): Matcher = {
    "type" : "matches",
    expected: [(actual) -> do {
        if(actual is String)
            if(actual dw::Core::matches regex) createMatch() as MatcherDiff
            else createDiff("A string matching $regex", actual, "(root)") as MatcherDiff
        else notStringDiff(actual)
     }]
} as Matcher

fun containsString(value: String): Matcher = {
    "type" : "containsString",
    expected: [(actual) -> do {
        if(actual is String)
            if(actual contains value) createMatch() as MatcherDiff
            else createDiff("A string containing $value", actual, "(root)") as MatcherDiff
        else notStringDiff(actual)
    }]
} as Matcher

fun startsWith(prefix: String): Matcher = {
    "type" : "startsWith",
    expected: [(actual) -> do {
        if(actual is String)
            if(dw::Core::startsWith(actual, prefix)) createMatch() as MatcherDiff
            else createDiff("A string starting with $prefix", actual, "(root)") as MatcherDiff
        else notStringDiff(actual)
    }]
} as Matcher

fun endsWith(suffix: String): Matcher = {
    "type" : "endsWith",
    expected: [(actual) -> do {
        if(actual is String)
            if(actual dw::Core::endsWith suffix) createMatch() as MatcherDiff
            else createDiff("A string ending with $suffix", actual, "(root)") as MatcherDiff
        else notStringDiff(actual)
    }]
} as Matcher

fun isEmptyString(): Matcher = {
    "type" : "isEmptyString",
    expected: [(actual) -> do {
        if(actual is String)
            if(dw::Core::isEmpty(actual)) createMatch() as MatcherDiff
            else createDiff("An empty string", actual, "(root)") as MatcherDiff
        else notStringDiff(actual)
    }]
} as Matcher

fun isEmptyOrNullString(): Matcher = {
    "type" : "isEmptyOrNullString",
    expected: [(actual) -> do {
        if((actual == null) or (actual is String))
            if((actual == null) or dw::Core::isEmpty(actual)) createMatch() as MatcherDiff
            else createDiff("An empty or null string", actual, "(root)") as MatcherDiff
        else notStringDiff(actual)
    }]
}  as Matcher

fun equalToIgnoringCase(value: String): Matcher = {
    "type" : "equalToIgnoringCase",
    expected: [(actual) -> do {
        if(actual is String)
            if(lower(value) == lower(actual)) createMatch() as MatcherDiff
            else createDiff("'$value' ignoring case", actual, "(root)") as MatcherDiff
        else notStringDiff(actual)
    }]
} as Matcher

fun equalToIgnoringWhiteSpace(value: String): Matcher = {
    "type" : "equalToIgnoringWhiteSpace",
    expected: [(actual) -> do {
        var removeMultipleWhiteSpaces = (value) -> value replace /\s+/ with " "
        ---
        if(actual is String)
            if(removeMultipleWhiteSpaces(actual) == removeMultipleWhiteSpaces(value)) createMatch() as MatcherDiff
            else createDiff(removeMultipleWhiteSpaces(value), actual, "(root)") as MatcherDiff
        else notStringDiff(actual)
    }]
} as Matcher

fun stringContainsInOrder(values: Array<String>): Matcher = {
    "type" : "stringContainsInOrder",
    expected: [(actual) -> do {
      var getValuesIndexes = () -> values map ((item, index) -> actual find item) // Get the indexes of all ocurrences of the given value

      fun orderedIndexes() = do {
        getValuesIndexes() reduce ((indexes, accumulator) -> do {
            indexes filter ((item, index) -> do {
                accumulator some ((element) -> element < item )
            })
        })
      }

      var getValuesAsString = () -> values joinBy(", ")
      ---
      if(actual is String)
          if(dw::Core::isEmpty(orderedIndexes())) createDiff("$(getValuesAsString()), in order", actual, "(root)") as MatcherDiff
          else createMatch() as MatcherDiff
      else notStringDiff(actual)
    }]
} as Matcher

//Comparison Matchers
fun greaterThan(value: Comparable): Matcher = {
    "type" : "greaterThan",
    expected: [value]
} as Matcher

fun greaterThanOrEqualTo(value: Comparable): Matcher = {
    "type" : "greaterThanOrEqualTo",
    expected: [value]
} as Matcher

fun lessThan(value: Comparable): Matcher = {
    "type" : "lessThan",
    expected: [value]
} as Matcher

fun lessThanOrEqualTo(value: Comparable): Matcher = {
    "type" : "lessThanOrEqualTo",
    expected: [value]
} as Matcher

fun closeTo(value: Number, error: Number): Matcher = {
    "type" : "closeTo",
    expected: [value, error]
} as Matcher

//Iterable Matchers
fun everyItem(matcher: Matcher): Matcher = {
    "type" : "everyItem",
    expected: [matcher]
} as Matcher

fun hasItem(matcherOrValue: Any): Matcher = {
    "type" : "hasItem",
    expected: [if (matcherOrValue is Matcher) matcherOrValue else equalTo(matcherOrValue)]
} as Matcher

fun hasSize(matcherOrNumber: Matcher | Number): Matcher = {
    "type" : "hasSize",
    expected: [if (matcherOrNumber is Matcher) matcherOrNumber else equalTo(matcherOrNumber)]
} as Matcher

fun isEmpty(): Matcher = {
    "type" : "isEmpty",
    expected: []
} as Matcher

fun hasKey(matcherOrString: Matcher| String): Matcher = {
    "type" : "hasKey",
    expected: [if (matcherOrString is Matcher) matcherOrString else equalTo(matcherOrString)]
} as Matcher

fun hasValue(matcherOrValue: Any): Matcher = {
    "type" : "hasValue",
    expected: [if (matcherOrValue is Matcher) matcherOrValue else equalTo(matcherOrValue)]
} as Matcher


//Resource Functions

fun getResourceAsStream(path: String) = java!org::mule::munit::tools::util::GetResourceFunctions::getResourceAsStream(path)

fun getResourceAsReusableStream(path: String) = java!org::mule::munit::tools::util::GetResourceFunctions::getResourceAsReusableStream(path)

fun getResourceAsString(path: String, encoding:String = null):String = java!org::mule::munit::tools::util::GetResourceFunctions::getResourceAsString(path, encoding)

fun getResourceAsByteArray(path: String) = java!org::mule::munit::tools::util::GetResourceFunctions::getResourceAsByteArray(path)

fun queueSize(name: String|Null = null) = java!org::mule::munit::tools::util::queue::api::TemporaryQueueRule::size(name)

fun createMessage(payload: Any, attributes: Any = null) = java!org::mule::munit::tools::util::MuleComponentsFunctions::createMessage(payload, null, attributes, null)

fun createMessage(payload: Any, mimeType: String|Null , attributes: Any, attributeMimeType: String|Null) = java!org::mule::munit::tools::util::MuleComponentsFunctions::createMessage(payload, mimeType, attributes, attributeMimeType)