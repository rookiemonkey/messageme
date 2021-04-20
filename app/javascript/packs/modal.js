import SearchItem from '../components/searchItem';
import SearchItemEmpty from '../components/searthItemEmpty';
import Loader from '../components/loader';

class Modal {
  constructor() {
    this.searchingId = 0
    this.modal = document.getElementById("myModal");
    this.button = document.getElementById("add_btn");
    this.span = document.getElementsByClassName("close")[0];
    this.form = document.getElementById("form_user_search");
    this.input = document.getElementById("form_user_search_input");
    this.results = document.getElementById("user_search_results");
  }

  search = async () => {
    // arrow function becuase setTimeout changes the context of this
    const raw = await fetch(`/api/users?username=${this.input.value}`)
    const data = await raw.json()
    this.processData(data)
  }

  initialize() {
    this.button.onclick = () => this.modal.style.display = "block"
    this.span.onclick = () => this.modal.style.display = "none"
    this.form.onsubmit = () => false

    this.input.addEventListener('keyup', () => {
      if (!this.input.value) return null
      clearTimeout(this.searchingId)
      this.startLoader()
      this.searchingId = setTimeout(this.search, 1500)
    })
  }

  processData(data) {
    this.removeResults()
    if (!data.length) return this.results.innerHTML = new SearchItemEmpty().render()
    data.forEach(user => this.results.insertAdjacentElement('beforeend', new SearchItem(user).render()))
  }

  startLoader() {
    this.removeResults()
    new Loader('#user_search_results').startLoader()
  }

  removeResults() {
    this.results.innerHTML = ``
  }
}

new Modal().initialize()