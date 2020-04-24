/// <reference types="Cypress" />

function fillSubjectForm(name, description, color) {
  cy.get('[data-test=name]')
    .clear()
    .type(name)
    .should('have.value', name)

  cy.get('[data-test=description]')
    .clear()
    .type(description)
    .should('have.value', description)

  if (color) {
    cy.get('[data-test=color]')
    .clear()
    .type(color)
    .should('have.value', color)
  }
}

function submitSubjectForm() {
  cy.get('[data-test=subject-form]').submit()
}

function getId() {
}

describe('Subjects', () => {
  beforeEach(() => {
    cy.signUpAndLogin()
  })

  it('Creates, updates, shows and deletes subjects successfully', () => {
    // Create a new subject
    cy.visit('/subjects/new')
    cy.url().should('include', '/subjects/new')

    cy.contains('New Subject')

    let name = "Test Subject"
    let description = "Test Description"
    fillSubjectForm(name, description)
    submitSubjectForm()

    // Show the newly created subject
    cy.contains('Subject created successfully.')
    cy.url().then(url => {
      let pattern = /subjects\/(\d+)/
      let result = url.match(pattern)
      let subjectId = result[1]

      cy.contains(name)
      cy.contains(description)
      cy.contains("#666666")

      cy.get('[data-test=edit-link]').click()

      // Update the created subject
      name = "Test Updated Subject"
      description = "Test Updated Description"
      let color = "#FF00FF"
      fillSubjectForm(name, description, color)
      submitSubjectForm()

      // Check that the updated subject has the updated info there
      cy.contains('Subject updated successfully.')
      cy.contains(name)
      cy.contains(description)
      cy.contains(color)

      // Delete the subject
      cy.visit('/subjects')
      cy.get(`[data-test='delete-link'][data-to='/subjects/${subjectId}']`).click()

      cy.contains('Subject deleted successfully.')
    })
  })
})
