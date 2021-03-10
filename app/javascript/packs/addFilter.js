
const listenForFieldChanges = () => {
  const fieldsetSelectFields = document.querySelectorAll("fieldset > .query_filters_column_name > select");

  const comparisonOptions = {
    "datetime": ["Before", "After",	"On", "Is Empty", "Is Not Empty"],
    "string":["Matches",	"Does Not Match",	"Contains",	"Does Not Contain",	"Starts With",	"Ends With",	"is Empty", "Is Not Empty"],
    "text":["Matches",	"Does Not Match",	"Contains",	"Does Not Contain",	"Starts With",	"Ends With",	"is Empty", "Is Not Empty"],
    "boolean":["Is True", "Is False"],
    "float":["Equals",	"Does Not Equal",	"Greater Than",	"Less Than",	"Greater Than or Equal To",	"Less Than or Equal To",	"Is Empty",	"Is Not Empty"],
    "integer":["Equals",	"Does Not Equal",	"Greater Than",	"Less Than",	"Greater Than or Equal To",	"Less Than or Equal To",	"Is Empty",	"Is Not Empty"]
  };
  
  const fieldTypes = {
    "datetime":"datetime-local", 
    "string":"string", 
    "text":"string",
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

const insertRemoveFilter = (Fieldset, newId) => {
  console.log(Fieldset);
  if (newId === undefined) {
    var parent = Fieldset.parentNode;
    var wrapper = document.createElement('div');
    wrapper.className = "d-flex"
    // set the wrapper as child (instead of the element)
    parent.replaceChild(wrapper, Fieldset);
    // set element as child of wrapper
    wrapper.appendChild(Fieldset);
    Fieldset.insertAdjacentHTML('afterend', `<button class="filter-btn button-secondary button-bottom" style="align-self: flex-end; white-space: nowrap;" id="remove-filter-0">Delete filter</button>`);
  } else {
    var parent = Fieldset.parentNode;
    var wrapper = document.createElement('div');
    wrapper.className = "d-flex"
    // set the wrapper as child (instead of the element)
    parent.replaceChild(wrapper, Fieldset);
    // set element as child of wrapper
    wrapper.appendChild(Fieldset);
    Fieldset.insertAdjacentHTML('afterend', `<button class="filter-btn button-secondary button-bottom" style="align-self: flex-end; white-space: nowrap;" id="remove-filter-${newId}">Delete filter</button>`);
  }
    console.log(Fieldset.nextElementSibling);
  Fieldset.nextElementSibling.addEventListener("click", (event) => {
    event.preventDefault();
    console.log("Clicked. Event started");
    Fieldset.remove();
    event.target.remove();
    console.log("Clicked. Event ended");
  });
}

const addFilter = () => {
  const createButton = document.querySelector("#add-filter");
  const Fieldset = document.querySelector('[id="0"]')
  console.log(Fieldset);
  insertRemoveFilter(Fieldset);
  const FieldsetText = Fieldset.outerHTML;
  createButton.addEventListener("click", (event) => {
    event.preventDefault();
    console.log(document.querySelector('#fieldset-container').lastElementChild.firstChild);
    // console.log(document.querySelector('#fieldset-container').lastElementChild.previousSibling);
    const lastId = document.querySelector('#fieldset-container').lastElementChild.firstChild.id;
    const newId = parseInt(lastId, 10) + 1;
    const newFieldset = FieldsetText.replace(/0/g, newId);

    document.querySelector("#fieldset-container").insertAdjacentHTML(
      "beforeend", newFieldset
    );
    const newField = document.querySelector(`[id="${newId}"`);
    insertRemoveFilter(newField, newId);
    listenForFieldChanges();
  });
}

export { addFilter, listenForFieldChanges, addDivToQueryFieldsInput }