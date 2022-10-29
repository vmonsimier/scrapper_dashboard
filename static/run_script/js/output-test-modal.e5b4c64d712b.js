Vue.component('output-test-modal', {
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
                  console.log(response.data.toString());
                  this.content = response.data.toString();
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
            <span>Test Output</span>
            <img src="/static/run_script/img/cross.png" class="modify" @click="dialog=false" />
          </v-card-title>
          <v-card-text>
            <p>{{ content }}</p>
          </v-card-text>
        </v-card>
      </v-dialog>`
  })
  