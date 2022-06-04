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
                    <v-col class="d-flex">
                        <v-select
                            :availables="availables"
                            label="Choose a filebase..."
                            v-model="availables"
                            dense
                            outlined
                        />
                    </v-col>
                </v-row>
                <file_players v-if="fileBase === 'players'" :key="fileBase" />
            </template>
        </div>
    `
}