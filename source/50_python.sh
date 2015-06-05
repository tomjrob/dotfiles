# Update pip and install global modules.
pip_globals=(
  virtualenv
  virtualenvwrapper
  aws-cli
)

function pip_install() {
  e_header "Updating pip"
  pip install --update pip
  if (( ${#pip_globals[@]} > 0 )); then
    e_header "Installing pip modules: ${pip_globals[*]}"
    gpip install --upgrade "${pip_globals[@]}"
  fi
}
