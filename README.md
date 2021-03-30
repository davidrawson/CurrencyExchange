# FreeAgent Coding Challenge

Thank you for your interest in the FreeAgent Coding Challenge. This template is a barebones guide to get you started. Please add any gems, folders, files, etc. you see fit in order to produce a solution you're proud of.

## Coding Challenge Instructions

Please see the INSTRUCTIONS.md file for more information.

## Your Solution Setup and Run Instructions

Please include instructions on how to setup and run your solution here.

## Your Design Decisions

We'd love to hear your thoughts around any design decisions you made while coding your solution.

First impressions:
The file readers class(es) should implement an interface forcing certain things. A factory could be used for for these instances. Should the file reader know its base currency? No, it just reads the file. How to interogate the file and what the base currency is should be dealt with elsewhere. The base/home currency and how the filename is entered is a significant issue to resolve.

Problem: how to set the base currency when the arguments for rate() cannot be changed.
How to disguish between the json reader for EUR and json reader for GBP
They're gonna have to be hard-coded, perhaps with getter and setter methods

The Factory: Seemed the best way to enable different formats to be added in the future. I did consider whether the Adapter pattern would work but decided on Factory.
The Factory pattern should have an abstract or base class but I thought it was unncessary until a second format was to be implemented.

Added e2mmap to the gemfileas it was required by irb. Unclear if this was an issue with my installation.

Refactored to create the Reader and get the rates from the CurrencyExchange class to aid with testing.
