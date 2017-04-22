Alchemy Generator
==============================================

[<img src="https://raw.githubusercontent.com/SirWellington/alchemy/develop/Graphics/Logo/Alchemy-Logo-v7-name.png" width="200">](https://github.com/SirWellington/alchemy)

## "More Data => Better tests"
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![Build Status](https://travis-ci.org/SirWellington/AlchemyGenerator.svg?branch=develop)](https://travis-ci.org/SirWellington/AlchemyGenerator)


# Purpose
Part of the [Alchemy](https://github.com/SirWellington/alchemy) Series, this library makes it easier to test your code by providing generators for common Objects and Data.

Introducing randomized data to tests helps improve test quality by assuring that your code can work over a wide range of data values,
and not just what you hard-code in. It also increases confidence that code will work in a variety of circumstances.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


<!-- END doctoc generated TOC please keep comment here to allow auto update -->


# Download

To use, simply add the following Carthage dependency

## Release
```swift
github "SirWellington/alchemy-generator-swift" "develop"
```

API
==============================================

```swift
import AlchemyGenerator
```

## Numbers

### Integers

```swift
//A number in the range [-50, 50)
let anInteger: Int = AlchemyGenerator.integers(from: -50, to: 50)
```

### Longs

```swift
//Get any positive long
let somePositiveNumber: Long = AlchemyGenerator.positiveLong()

//alternative way using computed properties
somePositiveNumber = AlchemyGenerator.Longs.positive
```

### Doubles
```swift
//A double in the range [0.1, 1999.0]

let double = AlchemyGenerator.doubles(from: 0.1, to: 1999.0)
```

## Strings

Randomized strings can be conveniently accessed using computed properties in the
`AlchemyGenerator.Strings` class.

### Alphabetical
Uses the Latin Alphabet, a-z | A-Z

```swift
let alphabetical: String = AlchemyGenerator.alphabeticalString(ofSize: 10)
```

### Alphanumeric
Uses the Latin Alphabet, and numbers 0-9.

```swift
let alphanumeric = AlchemyGenerator.alphanumericString()
```

### Numeric
Creates strings composed of the digits 0-9.

```swift
let zipCode = AlchemyGenerator.numericString(ofSize: 5)
```

### Hexadecimal
```swift
let hex = AlchemyGenerator.hexadecimalString(ofSize: 10)

//Uses a computed property
let anotherRandomHex = AlchemyGenerator.Strings.hex
```

### Any String
These strings may have unicode characters as well. These are great for testing against international character sets as well.

```swift
let anyString = AlchemyGenerator.Strings.anyString
let anyStringSized = AlchemyGenerator.anyString(ofSize: 13)
```
### UUIDs
Guaranteed unique strings

```swift
//coming soon
```
### From Fixed Set
Strings can be generated from a preselected set of String values.
```swift
let stringFromList = AlchemyGenerator.stringFrom(list: ["admit", "learn", "let in", "hear", "listen", "obey"])
```

## Binary

### Bytes
> Coming soon

## Collections
> Coming Soon
<!--
### Lists

```swift
List<String> randomStrings = listOf(alphabeticString(20), 100);
List<Integer> ages = listOf(integers(1, 100));
```

### Maps
```swift
AlchemyGenerator<String> names = alphabeticalStrings();
AlchemyGenerator<Integer> ages = integers(1, 100);

int numberOfPeople = 50;
Map<String,Integer> ages = mapOf(names, ages, numberOfPeople);
``` -->

## Dates and Times
> Coming Soon

## Enums

> Coming Soon

## People

Our code very often works people, and information about them
`tech.sirwellington.alchemy.generator.PeopleGenerators`

```swift
String name = names().get();
int age = one(adultAges());
String phoneNumber = one(phoneNumberStrings());
String email = one(emails());
```

## POSOs

POSOs (plain old swift objects) are dumb data objects, that is they tend to contain no functionality other than getters/setters and value methods
like `equals()`, `hashCode()`, and `description()`.
Alchemy Generator provides Automatic Generation of POJOs.



Let's say you have a class like
<!--
```swift
class Computer
{
    private int yearReleased;
    private String modelName;
    private double cost;
    private String manufacturer;
    private String operatingSystem;
}
```

Rather than creating Boiler Plate generation code for each pojo, just use the `pojos()` generator.

```
@Test
public void testPurchaseOrder()
{
    Computer computer = one(pojos(Computer.class));
    shoppingCart.add(computer);
    shoppingCart.order();
    ...
}
```
### Nested POJOs

The POJO generator contains a sophisticated recursive algorithm to generate complex hierarchies of POJOs,
as long as it all eventually boils to down to primitive types (Integer, String, Double, Long, Date, etc).

```swift
class Developer
{
    private String name;
    private String alias;
    private int age;
    private Computer developerMachine;
    private Computer serverMachine;
}

Developer developer = one(pojos(Developer.class));

assertThat(developer, notNullValue());
assertThat(developer.name, not(isEmptyOrNullString()));
assertThat(developer.age, greaterThan(0));
assertThat(developer.developerMachine, notNullValue());
...
```

> IMPORTANT: There can be NO circular references. A Computer cannot contain a Developer at the same time that Developer contains Computer.
> This would cause a StackOverflow.

### Collections

`tech.sirwellington.alchemy.generator.CollectionGenerators`

The POJO Generator also handles Generic  `enum`, `List`, `Set`, and `Map` types that contain either Primitive Types, or other POJOs.
```swift
class City
{
    private String name;
    private long population;
    private List<Developer> developersInTown;
    private Map<String, Building> addressDirectory;
}

City sampleCity = one(pojos(City.class));
```

> IMPORTANT: Complicated and nested data structures increase the amount of time of Object Generation, since for each
> Collection, the algorithm must recurse to generate more POJOs for the collection.
> This library was designed for Unit Testing purposes, however, and so performance is less important.

# Networking
`tech.sirwellington.alchemy.generator.NetworkGenerators`

`NetworkGenerators` contains generation code for Networking related concepts and data, such as URLs, hostnames, ports, etc.

## URLs
```swift
URL httpUrl = one(httpUrls());
URL httpsUrl = one(httpsUrls());
URL tcpUrl = one(urlsWithProtocol("tcp"));
```

## Hostnames
Create Network names in accordance to standards.

```swift
String hostname = one(localNetworkNames());
hostname = one(fullyQualifiedDomainNames());
```

## Ports
```swift
int port = one(ports());
```

## MAC Addresses
> Coming Soon. -->


# Requirements

+ Swift 3
+ XCode 8
+ Carthage


# Feature Requests
Feature Requests are definitely welcomed! **Please drop a note in [Issues](https://github.com/SirWellington/alchemy-generator-swift/issues).**

# Release Notes

## 1.0
+ Initial Public Release

# License

This Software is licensed under the Apache 2.0 License

http://www.apache.org/licenses/LICENSE-2.0
