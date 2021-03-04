
const listenForFieldChanges = () => {
  const fieldsetSelectFields = document.querySelectorAll("fieldset > .query_filters_column_name > select");

  const comparisonOptions = {
    "datetime": ["Before", "After",	"On", "Between", "Is Empty", "Is Not Empty"],
    "string":["Equals",	"Does Not Equal",	"Contains",	"Does Not Contain",	"Starts With",	"Ends With",	"is Empty", "Is Not Empty"]
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
  }));
}



const addFilter = () => {
  const createButton = document.querySelector("#add-filter");

  createButton.addEventListener("click", (event) => {
    event.preventDefault()
    const lastId = document.querySelector('#fieldset-container').lastElementChild.id
    const newId = parseInt(lastId, 10) + 1;
    const newFieldset = document.querySelector('[id="0"]').outerHTML.replace(/0/g, newId)

    document.querySelector("#fieldset-container").insertAdjacentHTML(
      "beforeend", newFieldset
    );
    listenForFieldChanges();
  });
}

export { addFilter, listenForFieldChanges }