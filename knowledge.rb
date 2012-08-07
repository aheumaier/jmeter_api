class C
  attribute 'a'
end
   
o = C::new
o.a = 42  # setter - sets @a
o.a       # getter - gets @a 
o.a?      # query  - true if @a
