## Reflection

I really enjoyed learning how to build a Grape API. It was not nearly as complex as I first anticipated. My biggest challenges included testing the post method and deciding where to put certain methods. For example, I started out by simply having a Record class, Parser module, and the API. While refactoring, I realized it made more sense to have some type of RecordCollection class to hold the Record objects and do the sorting.

My biggest challenge with testing was separating my test database from the development database. I know how to use mocks and stubs with RSpec, but I had to redesign how my Parser module took the csv file. I'd really appreciate any/all feedback on my code!