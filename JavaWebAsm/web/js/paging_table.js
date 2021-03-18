
function paging() {
	const rowsPerPage = 10;
	const table = document.getElementById('my-table');
	const tableBody = table.getElementsByTagName("tbody")[0];
	const rows = tableBody.getElementsByTagName("tr");
	const rowsCount = rows.length;
	const pageCount = Math.ceil(rowsCount / rowsPerPage);
	const numbers = document.getElementById('numbers');
	const itemPaging = document.getElementsByClassName("item-paging");

	for (var i = 0; i < pageCount; i++) {
		numbers.innerHTML += '<li><a class="item-paging" href="#">' + (i + 1) + "</a></li>";
	}
	let currentActive = 0;

	activeClass(currentActive);
	displayRows(1);
	for (let i = 0; i < itemPaging.length; i++) {
		itemPaging[i].addEventListener("click", function (e) {
			e.preventDefault();
			document.getElementsByClassName("item-paging")[currentActive].classList.remove("active");
			currentActive = parseInt(itemPaging[i].text) - 1;
			document.getElementsByClassName("item-paging")[currentActive].className = "active item-paging";
			displayRows(parseInt(itemPaging[i].text));
		});
	}

	function displayRows(index) {
		var start = (index - 1) * rowsPerPage;
		var end = start + rowsPerPage;
		for (var i = 0; i < rows.length; i++) {
			rows[i].style.display = "none";
		}
		if (index == pageCount) {
			for (var i = start; i <= rowsCount; i++) {
				rows[i].style.display = null;
			}
		} else {
			for (var i = start; i < end; i++) {
				rows[i].style.display = null;
			}
		}

	}

}
const activeClass = k => {
	const active = document.getElementsByClassName("item-paging")[k].className = "item-paging active";
}
paging();

