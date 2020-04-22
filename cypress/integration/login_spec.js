/// <reference types="Cypress" />

describe('User Login', () => {
  beforeEach(function() {
    cy.signUpAndLogin()
  })

  it('Logs an exisiting user in', function() {
    const { email, password } = this.currentUser

    cy.visit('/auth/identity')
    cy.url().should('include', '/auth/identity')

    cy.get('[data-test=email]')
      .type(email)
      .should('have.value', email)

    cy.get('[data-test=password]')
      .type(password)

    cy.get('[data-test=login-form]').submit()

    cy.contains('Successfully authenticated.')
  })
})
