describe('Home Page', () => {

  it('visits the home page', () => {
    cy.visit('/')
    cy.get(".products article").should("be.visible");
  })

})