---
hide:
 - navigation
 - toc
---
<style>
  .md-typeset h1,
  .md-content__button {
    display: none;
  }
</style>

<script src="https://d3js.org/d3.v4.min.js"></script>
<script src="https://zalando.github.io/tech-radar/release/radar-0.8.js"></script>
<svg id="radar" style="height: 1000px;"></svg>
<script>
fetch('./radar.json').then(function(response) {
  return response.json();
}).then(function(data) {
  radar_visualization({
    repo_url: "https://github.com/zalando/tech-radar",
    title: "Cartman Tech Radar",
    svg_id: "radar",
    date: data.date,
    colors: {
        background: "#fff",
        grid: "#bbb",
        inactive: "#ddd"
    },
    width: 1425,
    height: 1000,
    scale: 1.0,
    font_family: "Arial, Helvetica",
    print_layout: true,
    links_in_new_tabs: true,
    quadrants: [
      { name: "Languages & Frameworks" },
      { name: "Infrastructure & Tools" },
      { name: "Datastores" },
      { name: "Platforms & Ecosystems" },
    ],
    rings: [
      { name: "ADOPT", color: "#5ba300" },
      { name: "TRIAL", color: "#009eb0" },
      { name: "ASSESS", color: "#c7ba00" },
      { name: "HOLD", color: "#e09b96" }
    ],
    entries: data.entries
  });
}).catch(function(err) {
  console.log('Error loading radar.json', err);
});
</script>
