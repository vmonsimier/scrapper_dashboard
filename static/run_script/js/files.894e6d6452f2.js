const files = {
    data() {
        return {
            fileBase: 'Players',
            availables: ['Players']
        }
    },

    template: `
        <div id="files-template">
            <template>
                <v-row align="center">
                    <v-col class="d-flex" cols="4">
                        <v-select
                            :items="availables"
                            label="Choose a filebase..."
                            v-model="fileBase"
                        />
                    </v-col>
                </v-row>
                <file_players v-if="fileBase === 'players'" />
            </template>
        </div>
    `
}