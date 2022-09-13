describe('Products Page', () => {

  it('visits a product page from the homepage', () => {
    cy.visit('/')
    cy.get(".products article").first().click();

    cy.get('.product-detail h1').should("have.text", "Scented Blade")
  })


})