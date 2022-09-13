describe('Home Page', () => {

  it('visits the home page and finds a product', () => {
    cy.visit('/')
    cy.get(".products article").should("be.visible");
  })

  it('There is 2 products on the home page', () => {
    cy.get(".products article").should("have.length", 2)
  })
})