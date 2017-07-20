CREATE (cdus {name: "CDU"})
CREATE (examples {name: "Example"})
CREATE (references {name; "References"})
CREATE 
    (c:CDU { number: "<01>", description:"<02>" } ),
    (e1:example { occurence: "" , explanation: "" }), (c)-[:example]->(e1), 