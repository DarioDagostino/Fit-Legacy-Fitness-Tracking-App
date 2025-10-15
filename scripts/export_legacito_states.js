// Script para exportar estados de Legacito como PNG
const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

const states = [
  'motivado',
  'celebrando', 
  'neutral',
  'preocupado',
  'resiliente',
  'durmiendo',
  'pensativo',
  'energico'
];

async function exportLegacitoStates() {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  
  // Configurar viewport para móvil
  await page.setViewport({
    width: 400,
    height: 500,
    deviceScaleFactor: 2 // Para imágenes @2x
  });

  for (const state of states) {
    console.log(`Exportando estado: ${state}`);
    
    // Navegar al componente React
    await page.goto(`http://localhost:3000/legacito/${state}`);
    
    // Esperar a que se cargue el componente
    await page.waitForSelector('[data-testid="legacito-container"]');
    
    // Tomar screenshot del componente
    const element = await page.$('[data-testid="legacito-container"]');
    await element.screenshot({
      path: `assets/images/legacito/legacito_${state}.png`,
      type: 'png'
    });
    
    console.log(`✅ Exportado: legacito_${state}.png`);
  }

  await browser.close();
  console.log('🎉 Todos los estados exportados exitosamente!');
}

exportLegacitoStates().catch(console.error);
