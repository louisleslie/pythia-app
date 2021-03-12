const assignSelectedColumn = (selectedColumn) => {
  const countryIsos = {"826":"UK", "840":"US", "124":"Canada", "250":"France", "276":"Germany", "380":"Italy", "724":"Spain", "356":"India", "710":"South Africa", "036":"Australia"};
  const svg = d3.select('#map');
  svg.selectAll("*").remove();
  // d3.selectAll(" svg #map > *").remove();
  const width = +svg.attr('width');
  const height = +svg.attr('height');

  const projection = d3.geoNaturalEarth1();
  const pathGenerator = d3.geoPath().projection(projection);


  const g = svg.append('g');
  console.log(g);

  svg.call(d3.zoom().on('zoom', () => {
    g.attr('transform', d3.event.transform);
  }));

  Promise.all([
    JSON.parse(document.querySelector("#query-json-data").innerText),
    d3.tsv('https://unpkg.com/world-atlas@1.1.4/world/50m.tsv'),
    d3.json('https://unpkg.com/world-atlas@1.1.4/world/50m.json')
  ]).then(([queryData, tsvData, topoJSONdata]) => {
    console.log(queryData);
    console.log(tsvData); //checking it has been parsed correctly
    console.log(topoJSONdata);

    let columnMaximum = 0;

    const rowById = tsvData.reduce((accumulator, d) => {
      // console.log(d.iso_n3);
      // console.log(typeof(d.iso_n3));
      if (d.iso_n3 in countryIsos) {
        // console.log("----");
        let selectedColumnSum = 0;
        // console.log(selectedColumnSum);
        queryData.forEach((order) => {
          // console.log(order);
          // console.log(order.billing_country);
          if (order.billing_country == countryIsos[d.iso_n3]) {
            selectedColumnSum += order[selectedColumn];
            // console.log("----");
            // console.log(order[selectedColumn]);
            // console.log("----");
          }
        });
        // console.log("----");
        // console.log(selectedColumnSum);
        // console.log("----");
        // console.log(countryIsos[d.iso_n3]);
        selectedColumnSum > columnMaximum ? columnMaximum = selectedColumnSum : columnMaximum = columnMaximum;
        accumulator[d.iso_n3] = {"name": countryIsos[d.iso_n3], "subtotal": selectedColumnSum};
      } else {
        accumulator[d.iso_n3] = {"name": d.name, "subtotal": 0}; // Alex's original code
      };
      // accumulator[d.billing_country] = d;
      return accumulator;
    }, {});


    // const rowById = {};
    // tsvData.forEach(d => {
    //   rowById[d.iso_n3] = d;
    // });

    const countries = topojson.feature(topoJSONdata, topoJSONdata.objects.countries);
    // console.log(countries);
    countries.features.forEach(d => {
      // console.log(d.name);
      // Object.assign(d.properties, rowById[countryIsos[d.id]]);
      Object.assign(d.properties, rowById[d.id]);
    });

    const colorScale = d3.scaleLinear();
    // const colorScale = d3.scaleOrdinal();


    // const colorValue = d => d.properties.economy;
    const colorValue = d => d.properties.subtotal;

    // Get rid of duplicate category entries
    // Sort category entry values
    colorScale
      // .domain(countries.features.map(colorValue))
      // .domain(colorScale.domain().sort().reverse())
      // .range(d3.schemeSpectral[colorScale.domain().length]);
      .domain([0, columnMaximum])
      .range(["#E5E7EB", "#111827"]);

      // "#F9FAFB", "#F3F4F6" , "#E5E7EB" , "#9CA3AF", "#D1D5DB", "#6B7280", "#4B5563", "#374151", "#1F2937", "#111827"
    g.selectAll('path').data(countries.features)
      .enter().append('path')
        .attr('class', 'country')
        .attr('d', pathGenerator)
        .attr('fill', d => colorScale(colorValue(d)))
      .append('title')
        .text(d => d.properties.name + ': ' + colorValue(d));
  });
};

const listenForMapSelection = () => {



  const columnSelector = document.querySelector("#mapColumnNameSelector");

  const selectedColumn = columnSelector.value;
  assignSelectedColumn(selectedColumn);

  columnSelector.addEventListener("change", (event) => {
    assignSelectedColumn(event.target.value);
  });
}


export { listenForMapSelection };
