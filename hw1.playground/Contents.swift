//: # Homework 1 - Swift Playground

//: In order to answer the [EXPLAIN YOUR ANSWER HERE] questions,
//: you must go to Editor -> Show Raw Markup and edit the bracketed text.
//: Once done, go to Editor -> Show Rendered Markup to return to the previous view mode.


import UIKit


//: ## Q1: Optionals
class Words {
    var wordA : String!
    var wordB : String!
    
    init (wordA: String?, wordB: String?) {
        self.wordA = wordA
        self.wordB = wordB
    }

//: ### Are the values passed in to the **init** function and those set to the instance
//: ### variables the same type? If not, why?


//: The values passed into **init** and those set to the instance variables do not share the same type. The values passed into init are String optionals, meaning that we do not necessarily know whether we will get a String or not. This leaves the possibilities rather open ended (the user might choose to feed in integers for wordA and wordB instead, for example). On the other hand, the instance variables are forcibly unwrapped, and thus the programmer **expects** that whatever values they receive will be of type String. However, since the values passed into init are optionals, they may not end up being Strings and we could end up with a runtime error because the types do not match.


//: ## Q2: Variable Types and Function Types
    class func arePalindromes(words: [String]) -> Bool {//added "class"
        var reversedWords = words.map() {String($0.characters.reverse())}
        let numElements = words.count
        
        for var i = 0; i < numElements; i++ {
            if words[i] != reversedWords[i] {
                return false
            }
        }
        return true//added this line
    }
//: ### Why does the compiler dislike the **for loop**? Fix it.
//: ### What else is wrong with this function? You may have to refer to (but **not**
//: ### change) the code at the very bottom. Debug the function.


//: In the original code, "i" is declared as a constant (using "let") and thus cannot be modified. We must change it to a variable ("var") so it can be modified and incremented in the for loop (i++). In addition, we must change the method type from an instance method to a class method (referred to as a "type" method in the Swift documentation). This is because the "arePalindromes" function does not require us to create an instance of our class (Words) in order to be called. Rather, the method need only be associated with the type defined by our class (Words.arePalindromes(...)). Finally, we add a "return true" at the end of the method in case we go through the entire for loop -- meaning our array is made of palindromes.


//: ## Q3: More Functions and Object Initialization
    func isAnagram() -> Bool {//removed "class"
        var countLetters : [Character : Int] = [Character : Int]()//Line X
        let lenA = self.wordA.characters.count//changed "var" to "let"
        let lenB = self.wordB.characters.count//changed "var" to "let"
        
        if lenA != lenB {
            return false
        }
        
        let arrA = Array(self.wordA.characters)
        let arrB = Array(self.wordB.characters)
        
        for i in 0...lenA-1 {
            let letter = arrA[i]
            if let val = countLetters[letter] { //Line Y
                countLetters[letter] = val + 1
            } else {
                countLetters[letter] = 1
            }
        }
        
        for i in 0...lenB-1 {
            let letter = arrB[i]
            if let val = countLetters[letter] {
                countLetters[letter] = val - 1
            } else {
                return false
            }
        }
        
        for (_, count) in countLetters { //replaced "letter" with "_"
            if count != 0 {
                return false
            }
        }
        
        return true
    }
//: ### What is the problem with declaring **countLetters** as we do in **Line X**,
//: ### and then using it in **Line Y**? Fix it (by only changing **Line X**).
//: ### What else is wrong with this function? You may have to refer to (but **not**
//: ### change) the code at the very bottom. Debug the function.


//: While Line X declares a new dictionary and defines its types (Ints mapped to Characters), it fails to initialize it. Between Line X and Line Y, nothing is done to give the dictionary its initial value. This is problematic as Line Y introduces conditional checks to see if countLetters has any values. If this were to fail, the "else" clause seeks to give countLetters the value of "1" at the key "letter". This would not be an issue if countLetters were an empty dictionary (in this case, it has not even yet been initialized). Another fix was changing the method type to an instance method. The isAnagram method depends on accessing specific instance properties (in this case, the "wordA" and "wordB" instance variables) and running them against an algorithm. Thus, we need an instance of Words with its own values for wordA and wordB in order to proceed. Finally, a few changes were made according to the compiler's suggestions. lenA, lenB, arrA, and arrB began as variables but were changed to constants since they are never modified in the method. "for(letter, count)" was changed to "for(_, count)" because "letter" itself is never used in the for loop. We simply need to access the "count" value of each dictionary entry.
    
    
}


//: ## Check Your Answers
//: ### If you now see an output stream in the right sidebar, you have successfully
//: ### debugged the code above. Remember that you must also fully and correctly answer
//: ### all of the written questions above to receive full credit for this homework.


//: **DO NOT** touch any code below this point.
Words.arePalindromes(["hih", "racecar", "mom", "wow"])
Words.arePalindromes(["gene", "shawn", "hello"])
var wordsObj = Words.init(wordA: "anagram", wordB: "managra")
wordsObj.isAnagram()
wordsObj.wordA = "hello"
wordsObj.wordB = "what"
wordsObj.isAnagram()
