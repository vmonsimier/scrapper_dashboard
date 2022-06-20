const files = {
    data() {
        return {
            fileBase: 'players',
            availables: ['players']
        }
    },

    template: `
        <div id="files-template">
            <template>
                <v-row align="center">
                    <v-col class="d-flex" v-col="4">
                        <v-select
                            :availables="availables"
                            label="Choose a filebase..."
                            dense
                            outlined
                        />
                    </v-col>
                </v-row>
                <file_players v-if="fileBase === 'players'" />
            </template>
        </div>
    `
}