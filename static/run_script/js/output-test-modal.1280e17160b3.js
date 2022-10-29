Vue.component('update-scrapper-modal', {
    data() {
        return{
          dialog: false,
          content: ''
        }
    },
    methods: {
        getOutput() {
            axios.post(variables.API_URL + "output_test", {
                headers: {
                  'Access-Control-Allow-Origin': "*"
                },
                body: { path: 'result_output.txt' }
              })
                .then(response => {
                  this.content = response.data;
                })
        }
    },
    mounted: function () {
        this.getOutput();
    },
    template: `
     <v-dialog
        v-model="dialog"
        persistent
        max-width="800"
      >
        <template v-slot:activator="{ on, attrs }">
            <v-btn
                depressed
                color="error"
                v-on="on"
            >
                Output
            </v-btn>
        </template>
        <v-card>
          <v-card-title class="text-h5 title-modal">
            Test Output
          </v-card-title>
          <v-card-text>
            {{ content }}
          </v-card-text>
        </v-card>
      </v-dialog>`
  })
  