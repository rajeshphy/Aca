---
layout: default
title: Academic Records
---
<style>
details {
  margin-bottom: 0.8rem;
  padding: 0.6rem 0.8rem;
  background-color: #fdfdfd;
  border-left: 4px solid #007acc;
  border-radius: 8px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
  transition: all 0.3s ease;
  font-family: "Segoe UI", sans-serif;
}

details[open] {
  background-color: #eef7ff;
  border-left-color: #d84a2b;
}

details details {
  background-color: #fafafa;
  border-left: 3px solid #ccc;
}

details[open] details[open] {
  background-color: #fff8ec;
  border-left-color: #d27a00;
}

summary {
  position: relative;
  padding-left: 1.5rem;
  font-weight: 600;
  font-size: 1.05rem;
  cursor: pointer;
  list-style: none;
  color: #2a2a2a;
}

summary::before {
  content: "+";
  position: absolute;
  left: 0;
  font-size: 1.2rem;
  color: #007acc;
  transition: all 0.2s ease;
}

details[open] > summary::before {
  content: "−";
  color: #cc3300;
}

/* FILE LIST STYLE */
ul {
  margin: 0.4rem 0 0.6rem 1.5rem;
  padding-left: 0.5rem;
  list-style: none;
}

ul li {
  margin: 0.3rem 0;
  padding: 0.5rem 0.8rem;
  border-radius: 6px;
  font-size: 0.97rem;
  font-weight: 500;
  transition: background 0.3s ease;
}

/* Alternate background for list items */
ul li:nth-child(odd) {
  background-color: #96d4aa8e;
}

ul li:nth-child(even) {
  background-color: #c89999be;
}

/* FILE LINK STYLE */
a {
  text-decoration: none;
  color: #1a4d8f;
  display: block;
  border-left: 3px solid transparent;
  padding-left: 0.4rem;
}

a:hover {
  border-left: 3px solid #1a4d8f;
  background-color: #e9f3ff;
  color: #003366;
  border-radius: 4px;
}
</style>

<!-- <script>
  const password = prompt("Enter password:");
  if (password !== "rajmuri") {
    document.body.innerHTML = "<h2>Access Denied</h2>";
  }
</script> -->

{% for section in site.data.urls %}
<details>
  <summary>{{ section[0] | replace: '_', ' ' }}</summary>

  {% assign subsections = section[1] %}
  {% for subsection in subsections %}
  <details style="margin-left: 1em;">
    <summary>{{ subsection[0] | replace: '_', ' ' }}</summary>

    {% assign files = subsection[1] %}
    {% if files.size > 0 %}
    <ul>
      {% for file in files %}
      <li><a href="{{ site.baseurl }}/RECORDS/{{ section[0] }}/{{ subsection[0] }}/{{ file }}">{{ file }}</a></li>
      {% endfor %}
    </ul>
    {% else %}
    <p style="margin-left:1.5em;"><em>No files uploaded yet.</em></p>
    {% endif %}
  </details>
  {% endfor %}
</details>
{% endfor %}