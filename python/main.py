import requests

from flask import Flask, render_template

miner_hosts = [
    "mh01",
    "mh02",
    "mh03",
    "mh04",
    "mh05",
    "mh06",
    "mh07",
    "mh08",
    "mh09",
    "mh10",
    "mh11",
    "mh12",
    "mh13",
    "mh14",
    "mh15"
]


def get_rig_uptime(miner_stats):
    uptime_seconds = miner_stats.json().get('uptime')
    days = uptime_seconds // 86400
    hours = (uptime_seconds % 86400) // 3600
    minutes = ((uptime_seconds % 86400) % 3600) // 60
    return str(days) + "d " + str(hours) + "h " + str(minutes) + "m"


def get_rig_speed(miner_stats):
    devices = miner_stats.json().get("devices")
    rig_speed = 0
    gpu_number = 0
    for gpu_stat in devices:
        rig_speed = rig_speed + gpu_stat.get("speed")
        gpu_number = gpu_number + 1
    rig_av_speed = round((rig_speed / gpu_number) / 1000000, 1)
    return rig_av_speed


def get_rig_status(miner_stats):
    rcode = miner_stats.status_code
    if rcode == 200:
        return "OK"
    else:
        return "BAD"


def get_gpus_power_usage(miner_stats):
    devices = miner_stats.json().get("devices")
    gpus_power = 0
    for gpu_stat in devices:
        gpus_power = gpus_power + gpu_stat.get("power_usage")
    return gpus_power


def get_current_rigs_state():
    current_stats = []
    for miner_host in miner_hosts:
        try:
            miner_stats = requests.get("http://" + miner_host + ":3333/stat")
            m_stats = {"rig_name": miner_host, "rig_state": get_rig_status(miner_stats),
                       "rig_pwr_usage": get_gpus_power_usage(miner_stats),
                       "gpu_av_hr": get_rig_speed(miner_stats), "rig_uptime": get_rig_uptime(miner_stats)}
        except:
            m_stats = {"rig_name": miner_host, "rig_state": "ConnectionError",
                       "rig_pwr_usage": "Unavailable", "gpu_av_hr": "Unavailable",
                       "rig_uptime": "Unavailable"}
        current_stats.append(m_stats)
    return current_stats


app = Flask(__name__)


@app.route("/")
def mhstats_web():
    current_stats = get_current_rigs_state()
    return render_template('mhstats.html', current_stats=current_stats)


if __name__ == "__main__":
    app.run(debug=True)
