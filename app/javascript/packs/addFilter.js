
const listenForFieldChanges = () => {
  const fieldsetSelectFields = document.querySelectorAll("fieldset > .query_filters_column_name > select");

  const comparisonOptions = {
    "datetime": ["Before", "After",	"On", "Between", "Is Empty", "Is Not Empty"],
    "string":["Equals",	"Does Not Equal",	"Contains",	"Does Not Contain",	"Starts With",	"Ends With",	"is Empty", "Is Not Empty"],
    "boolean":["Is", "Is Not"],
    "float":["Equals",	"Does Not Equal",	"Greater Than",	"Less Than",	"Greater Than or Equal To",	"Less Than or Equal To",	"Is Empty",	"Is Not Empty"],
    "integer":["Equals",	"Does Not Equal",	"Greater Than",	"Less Than",	"Greater Than or Equal To",	"Less Than or Equal To",	"Is Empty",	"Is Not Empty"]
  };
  const fieldTypes = {
    "datetime":"datetime-local", 
    "string":"string", 
    "boolean":"checkbox", 
    "float":"number", 
    "integer":"number"
  };

  fieldsetSelectFields.forEach(selectField => selectField.addEventListener("change", (event) => {
    console.log("Something changed");
    console.log(event.target.value);
    // find the value of the option that changed. 
    let dataType = event.target.value.split("-")[1];
    let dataValue = event.target.value.split("-")[0];
    console.log(dataType);
    console.log(dataValue);
    let comparisonOperatorField = selectField.parentElement.nextElementSibling.querySelector("select");
    console.log(comparisonOperatorField);
    //comparisonOperatorField.type = "select"
    //comparisonOperatorField.classList.replace("text", "select");
    comparisonOperatorField.innerHTML = "";
    comparisonOptions[dataType].forEach( option => {
      comparisonOperatorField.insertAdjacentHTML('beforeend', `<option value="${option}">${option}</option>`);
    });
    let valueField = selectField.parentElement.nextElementSibling.nextElementSibling.querySelector("input");
    console.log(valueField);
    valueField.parentElement.className = `form-group ${dataType} optional query_filters_value`;
    valueField.previousSibling.className = `${fieldTypes[dataType]} optional`;
    valueField.className = `form-control ${fieldTypes[dataType]} optional`;
    valueField.type = fieldTypes[dataType];
  }));
}

const addDivToQueryFieldsInput = () => {
  const createButton = document.querySelector("#add-filter");
}

const addFilter = () => {
  const createButton = document.querySelector("#add-filter");
  const Fieldset = document.querySelector('[id="0"]').outerHTML
  createButton.addEventListener("click", (event) => {
    event.preventDefault();
    const lastId = document.querySelector('#fieldset-container').lastElementChild.id;
    const newId = parseInt(lastId, 10) + 1;
    const newFieldset = Fieldset.replace(/0/g, newId);

    document.querySelector("#fieldset-container").insertAdjacentHTML(
      "beforeend", newFieldset
    );
    listenForFieldChanges();
  });
}

export { addFilter, listenForFieldChanges, addDivToQueryFieldsInput }