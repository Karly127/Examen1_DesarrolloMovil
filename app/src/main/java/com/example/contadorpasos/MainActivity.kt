package com.example.contadorpasos
import android.Manifest
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Color
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.os.Bundle
import android.widget.Button
import android.widget.CheckBox
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat

class MainActivity : AppCompatActivity(), SensorEventListener {

    private var contador = 0
    private lateinit var sensorManager: SensorManager
    private lateinit var tvContador: TextView
    private var sensorPasos: Sensor? = null

    // reinicio
    private var pasosOffset = 0
    private var pasosDelSensor = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        tvContador = findViewById(R.id.tvContador)
        val btnSumar = findViewById<Button>(R.id.btnSumar)
        val btnDetalle = findViewById<Button>(R.id.btnDetalle)
        val btnReiniciar = findViewById<Button>(R.id.btnReiniciar) // Nuevo botón

        val cbPasos = findViewById<CheckBox>(R.id.cbPasos)
        val cbNatacion = findViewById<CheckBox>(R.id.cbNatacion)
        val cbFuerza = findViewById<CheckBox>(R.id.cbFuerza)
        val cbBox = findViewById<CheckBox>(R.id.cbBox)

        if(ContextCompat.checkSelfPermission(this,
                Manifest.permission.ACTIVITY_RECOGNITION) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this,
                arrayOf(Manifest.permission.ACTIVITY_RECOGNITION), 100)
        } else {
            configurarSensor()
        }

        btnSumar.setOnClickListener {
            contador++
            tvContador.text = "Pasos de hoy: $contador"
        }

        btnDetalle.setOnClickListener {
            val intent = Intent(this, Detail::class.java)
            intent.putExtra("PASOS", contador)
            startActivity(intent)
        }

        btnReiniciar.setOnClickListener {
            pasosOffset = pasosDelSensor
            contador = 0
            tvContador.text = "Pasos de hoy: 0"
        }

        configurarCheckBox(cbPasos)
        configurarCheckBox(cbNatacion)
        configurarCheckBox(cbFuerza)
        configurarCheckBox(cbBox)
    }

    private fun configurarCheckBox(checkBox: CheckBox) {
        checkBox.setOnCheckedChangeListener { _, isChecked ->
            if (isChecked) {
                checkBox.setBackgroundColor(Color.parseColor("#E8F5E9"))
                checkBox.setTextColor(Color.parseColor("#2E7D32"))
                val textoActual = checkBox.text.toString()
                checkBox.text = textoActual.replace("Pendiente de completar", "¡Completado!")
            } else {
                checkBox.setBackgroundColor(Color.parseColor("#FFFFFF"))
                checkBox.setTextColor(Color.BLACK)
                val textoActual = checkBox.text.toString()
                checkBox.text = textoActual.replace("¡Completado!", "Pendiente de completar")
            }
        }
    }

    private fun configurarSensor() {
        sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
        sensorPasos = sensorManager.getDefaultSensor(Sensor.TYPE_STEP_COUNTER)

        if(sensorPasos == null) {
            tvContador.text = "Error al configurar el sensor"
        }
    }

    override fun onResume() {
        super.onResume()
        sensorPasos?.let {
            sensorManager.registerListener(this, it, SensorManager.SENSOR_DELAY_UI)
        }
    }

    override fun onPause() {
        super.onPause()
    }

    override fun onSensorChanged(event: SensorEvent?) {
        if(event?.sensor?.type == Sensor.TYPE_STEP_COUNTER) {
            pasosDelSensor = event.values[0].toInt()

            if (pasosOffset == 0 && pasosDelSensor > 0) {
                pasosOffset = pasosDelSensor
            }
            val pasosReales = pasosDelSensor - pasosOffset
            tvContador.text = "Pasos de hoy: $pasosReales"
            contador = pasosReales
        }
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if(requestCode == 100) {
            if(grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                configurarSensor()
            }
            else{
                tvContador.text = "Permiso de sensor no concedido"
            }
        }
    }
}