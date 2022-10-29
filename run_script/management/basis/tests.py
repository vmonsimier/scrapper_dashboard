class Tests:
    output_file = '/home/valentinm/Documents/football/scrapper_dashboard/run_script/management/logs/result_output.txt'

    def eraseContentOutput(self):
        open(self.output_file, "w").close()

    def appendOutputFile(self, message):
        file = open(self.output_file, "a")
        file.write("{}\n".format(message))
        file.close()
        return 'Done'