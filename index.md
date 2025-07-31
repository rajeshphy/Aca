---
layout: default
title: Academic Records
---

<style>
details {
  margin-bottom: 0.5rem;
  padding: 0.3rem 0.5rem;
  background-color: #f9f9f9;
  border-left: 3px solid #007acc;
  border-radius: 5px;
  transition: all 0.3s ease;
}

details[open] {
  background-color: #e6f2ff; /* Light blue background when open */
  border-left: 3px solid #cc3300; /* Change border color to reddish */
}

/* Inner details (subdirectories) - optional contrast */
details details {
  background-color: #fcfcfc;
  border-left: 3px solid #999;
}

details[open] details[open] {
  background-color: #fff6e6; /* Light orange contrast for sub-open */
  border-left: 3px solid #cc6600; /* Orange-brown border */
}

summary {
  position: relative;
  padding-left: 1.5rem;
  font-weight: 600;
  cursor: pointer;
  list-style: none;
}

summary::before {
  content: "+";
  position: absolute;
  left: 0;
  font-size: 1.1rem;
  color: #007acc;
  transition: all 0.2s ease;
}

details[open] > summary::before {
  content: "−";
  color: #cc3300; /* Update icon color on open */
}

ul {
  margin: 0.3rem 0 0.3rem 1.5rem;
  padding-left: 0.5rem;
  list-style-type: disc;
}

a {
  text-decoration: none;
  color: #0066cc;
}

a:hover {
  text-decoration: underline;
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
      <li><a href="/RECORDS/{{ section[0] }}/{{ subsection[0] }}/{{ file }}">{{ file }}</a></li>
      {% endfor %}
    </ul>
    {% else %}
    <p style="margin-left:1.5em;"><em>No files uploaded yet.</em></p>
    {% endif %}
  </details>
  {% endfor %}
</details>
{% endfor %}