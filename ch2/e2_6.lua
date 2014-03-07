a = {}
a.a = a -- The 'a' field of the table a is a reference to a itself so a.a = a

print(a.a.a.a) --> The table a because a.a.a.a => (a.a).a.a => a.a.a => (a.a).a => a.a => a

a.a.a.a = 3 --> Assign the 'a' field of the table a to 3; now a = { a=3 }

print(a.a.a.a) -- a.a.a.a => (a.a).a.a => 3.a.a => :(
