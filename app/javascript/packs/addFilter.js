
const listenForFieldChanges = () => {
  const fieldsetOptionFields = document.querySelectorAll("fieldset > .query_filters_column_name > select")

  fieldsetOptionFields.forEach(optionfield => optionfield.addEventListener("change", (event) => {
    console.log("Something changed");
    console.log(event.target);
    console.log(event.target.text);
    console.log(event.target.value);
    console.log(optionfield);
    // find the value of the option that changed. 
  }));
}

export {  }

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