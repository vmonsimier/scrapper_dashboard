Vue.component('update-test-modal', {
    data() {
        return{
          dialog: false,
          id: this.testId,
          name: this.testName,
          path: this.testPath,
          file: this.testFile,
          testFiles: []
        }
    },
    props: ['testId', 'testName', 'testPath', 'testFile'],
    methods: {
      handleUpdate: async function(path) {
        this.dialog = false;
        this.$emit('setId', this.id);
        this.$emit('setName', this.name);
        this.$emit('setPath', this.path);
        this.$emit('setFile', this.file);
        this.$emit('updateTest');
      },
      getTestFiles: async function() {
        axios.get(variables.API_URL + 'api/test_files')
          .then(response => {
              let files = [];
              for(const item of response.data) {
                if(!item.is_result) {
                  files.push(item.path);
                }
              }
              this.testFiles = files;
          })
      },
    },
    
    mounted: function() {
        this.testFiles();
    },

    template: `
     <v-dialog
        v-model="dialog"
        persistent
        max-width="800"
      >
        <template v-slot:activator="{ on, attrs }">
            <img
              v-bind="attrs"
              v-on="on"
              class="modify"
              src="/static/run_script/img/edit.png" >
        </template>
        <v-card>
          <v-card-title class="text-h5 title-modal">
            Modifier {{ testName }}
          </v-card-title>
          <v-card-text>
            <v-form ref="form">
              <label>Name</label>
              <v-text-field
                v-model="name"
              >
              </v-text-field>
              <label>Path</label>
              <v-text-field
                v-model="path"
              >
              </v-text-field>
              <v-row>
                <v-col
                  cols="12"
                  sm="6"
                >
                  <label>Log files</label>
                  <v-combobox
                    v-model="file"
                    :items="testFiles"
                    multiple
                    dense
                  ></v-combobox>
                </v-col>
              </v-row>
            </v-form>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn
              depressed
              class="btn-execute"
              @click="handleUpdate"
            >
              Enregistrer
            </v-btn>
            <v-btn
              depressed
              color="error"
              @click="dialog = false"
            >
              Quitter sans sauvegarder
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>`
})
  