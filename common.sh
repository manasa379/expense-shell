log_file=/tmp/expense.log
download_and_extract() {

  echo Download $component code
  curl -s -o /tmp/$component.zip https://expense-artifacts.s3.amzonaws.com/$component.zip >>$log_file
  echo $?

  echo Extracting $ component code
  unzip /tmp/$ component.zip >>$log_file
  echo $?
}