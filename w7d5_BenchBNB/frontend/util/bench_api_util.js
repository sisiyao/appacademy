export const fetchBenches = (filters, success) => {
  $.ajax({
    method: "GET",
    url: "/api/benches",
    data: filters,
    success,
    error: () => console.log('error')
  });
};

// testing purposes
window.fetchBenches = fetchBenches;
