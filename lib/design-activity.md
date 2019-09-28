What classes does each implementation include? Are the lists the same?
Order, ShoppingCart, CartActivity are the three classes used. They are the same lists. 

Write down a sentence to describe each class.
Order calculates the total price by adding the sales tax to the other calculated prices from the other classes. ShoppingCart takes in entries. In implementation A it only holds the entries, and in B in can also calculate the price of the entire shopping trip minus the sales tax calculated by Order. CartEntry takes in the unit price and quanitity. In B it can calculate the price of an item depending on the quantity and unit price.

How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

Order class uses both ShoppingCart and Cartentry to calculate the total price of an order. ShoppingCart keeps track of entries and uses CartEntry to access the price of the items and sums each instance of CartEntry. 

What data does each class store? How (if at all) does this differ between the two implementations?
CartEntry: Stores unit price and quantity
ShoppingCart: Stores entries(of CartEntry)
Order: Stores ShoppingCart instance
They store the same things in each implementation.

What methods does each class have? How (if at all) does this differ between the two implementations?

In A CartEntry does not have a price method, but in B it does. It is the inverse for ShoppingCart. Order has a total price method in both A and B. In both implementations all have an initialize method. 

Consider the Order#total_price method. In each implementation:
        Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
A: Order calculates the price. 
B: ShoppingCart and Cartentry do the work of calculating price, while Order simply adds the tax. 

        Does total_price directly manipulate the instance variables of other classes?
        A: It does. 
        B: It does not. 

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
B is easier to modify because we only need to make a change in one place instead of the cascading effect in A.

Which implementation better adheres to the single responsibility principle?
B adheres to single responibility better, as each class is not calling on several classes to calculate multiiple things in each of it's method. 
Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?

B is more loosely coupled because the classes don't need to know so much about one another. 





Once you've responded to the prompts, git add design-activity.md and git commit!
Revisiting Hotel

Now that we've got you thinking about design, spend some time to revisit the code you wrote for the Hotel project. For each class in your program, ask yourself the following questions:

    What is this class's responsibility?
        You should be able to describe it in a single sentence.
        
    Is this class responsible for exactly one thing?
    Does this class take on any responsibility that should be delegated to "lower level" classes?
    Is there code in other classes that directly manipulates this class's instance variables?

You might recall writing a file called refactor.txt. Take a look at the refactor plans that you wrote, and consider the following:

    How easy is it to follow your own instructions?
    Do these refactors improve the clarity of your code?
    Do you still agree with your previous assesment, or could your refactor be further improved?

Activity

Based on the answers to each set of the above questions, identify one place in your Hotel project where a class takes on multiple roles, or directly modifies the attributes of another class. Describe in design-activity.md what changes you would need to make to improve this design, and how the resulting design would be an improvement.

If you need inspiration, remember that the reference implementation exists.

Then make the changes! Don't forget to take advantage of all the tests you wrote - if they're well structured, they should quickly inform you when your refactoring breaks something.

Once you're satisfied, git commit your changes and then push them to GitHub. This will automatically update your pull request.