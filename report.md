# Endpoints tested

- https://petstore.swagger.io/v2/pet (GET request for finding pet by id)
- https://petstore.swagger.io/v2/pet (POST request for adding pet)
- https://petstore.swagger.io/v2/pet (DELETE request for deleting pet by id)

# Test cenarios

1. Delete a pet with an id of 1
2. Searching for a pet with an id of 1 returns status code 404 and "Pet not found"
3. Adding a pet with and id of 1 and a name of "Petsi dawg" returns that pet object and status code 200
4. Trying to add a pet with incorrect data returns an error
5. Searching for a pet with an id of 1 returns a pet object with an id of 1

# Observations, issues etc.

I really hate that the documentation is rather minimal and lots of errors aren't handled correctly.
If you open the `tests.sh` file you can see that upon entering incorrect data for creating
a pet, you get back an error code of 500. Also I'd love to see some data validation so that
the error message would give back what was wrong a bit more precisely.
