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
  });
}

export { addFilter }