export const fetchBenches = (filters, success) => {
  $.ajax({
    method: "GET",
    url: "/api/benches",
    data: filters,
    success,
    error: () => console.log('error')
  });
};

export const createBench = (newBench, success) => {
  $.ajax({
    method: "POST",
    url: "/api/benches",
    data: { bench: newBench },
    success,
    error: (e) => console.log(e)
  });
};

// testing purposes
window.fetchBenches = fetchBenches;
