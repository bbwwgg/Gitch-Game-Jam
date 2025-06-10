LuckSystem = {
    sequence: [],
    index: 0,
    last_step: -1,
    current_value: 0,

    init: function() {
        for (var i = 0; i < 100; ++i) {
            array_push(this.sequence, irandom(100)); // Your real values
        }
    },

    use: function() {
        var current_step = current_time;
        if (this.last_step != current_step) {
            this.last_step = current_step;
            if (this.index < array_length(this.sequence)) {
                this.current_value = this.sequence[this.index];
                this.index += 1;
            } else {
                this.current_value = 0;
            }
        }
        return this.current_value;
    }
};