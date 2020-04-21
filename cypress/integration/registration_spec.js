/// <reference types="Cypress" />

describe('User Registration', () => {
  it('Signs a user up', () => {
    cy.visit('/registration/new')
    cy.url().should('include', '/registration/new')

    const uuid = () => Cypress._.random(0, 1e6)
    const id = uuid()
    const fullName = `Test Name ${id}`
    const email = `test${id}@example.com`
    cy.get('#user_full_name')
      .type(fullName)
      .should('have.value', fullName)

    cy.get('#user_email')
      .type(email)
      .should('have.value', email)

    cy.get('#user_password')
      .type('test')

    cy.get('form').submit()

    cy.contains('User created successfully.')
  })
})
