describe('Add Product To Cart', () => {
  it('visits a product page from the homepage and adds product to cart', () => {
    cy.visit('/')
    cy.get(".products article").first().click();

    cy.get('.product-detail h1').should("have.text", "Scented Blade")
    // Check cart is empty
    cy.get('.nav-link').should("contain", "My Cart (0)")

    cy.get('.btn').should("contain", "Add").click()
    // Check cart now has one item in it
    cy.get('.nav-link').should("contain", "My Cart (1)")
  })
})