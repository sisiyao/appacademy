export const signup = (user, success, error) => {
  $.ajax({
    url: '/api/users',
    method: 'POST',
    data: { user: user },
    success,
    error
  });
};

export const login = (user, success, error) => {
  $.ajax({
    url: '/api/session',
    method: 'POST',
    data: { user: user },
    success,
    error
  });
};

export const logout = (success, error) => {
  $.ajax({
    url: '/api/session',
    method: 'DELETE',
    success,
    error
  });
};

// testing purposes
window.signup = signup;
window.login = login;
window.logout = logout;
